#!/bin/bash

# Variables
BUCKET="gs://schzrophenia"
WORKDIR=$HOME
COUNT_DIR=$WORKDIR/counts
SAMPLE=("CTRL1" "CTRL2" "SAMPLE1" "SAMPLE2")

# Create Directory
mkdir -p $COUNT_DIR

# Download readsPerGene.out.tab file for each sample
echo "Downloading readsPerGene.out.tab files from bucket..."
for sample in "${SAMPLE[@]}"; do
    gcloud storage cp "$BUCKET/star_output/output/$sample/ReadsPerGene.out.tab" \
    "$COUNT_DIR/${sample}_ReadsPerGene.out.tab"
done
echo "All files in Count Directory"

# Install pandas if not already installed
sudo apt install python3-pip -y
pip3 install pandas

# Combine ReadsPerGene.out.tab files into a count matrix using Python
python3 << 'EOF'
import os
import pandas as pd

counts_dir = os.path.expanduser("~/counts")
samples = ["CTRL1", "CTRL2", "SAMPLE1", "SAMPLE2"]

counts_dict = {}

for sample in samples:
    filepath = os.path.join(counts_dir, f"{sample}_ReadsPerGene.out.tab")

    # Read file
    df = pd.read_csv(
        filepath,
        sep="\t",
        header=None,
        names=["GeneID", "Unstranded", "Forward", "Reverse"]
    )

    # Skip first 4 summary rows (N_unmapped, N_multimapping, etc.)
    df = df.iloc[4:]

    # Use unstranded counts (column 2) for unstranded RNA-seq
    counts_dict[sample] = df.set_index("GeneID")["Unstranded"]
    print(f"Loaded {sample}: {len(df)} genes")

# Combine into matrix
count_matrix = pd.DataFrame(counts_dict)

print(f"\nCount matrix shape: {count_matrix.shape}")
print(f"Samples: {list(count_matrix.columns)}")
print(f"\nFirst 5 rows:")
print(count_matrix.head())

# Basic stats
print(f"\nBasic statistics:")
print(count_matrix.describe())

zero_genes = (count_matrix.sum(axis=1) == 0).sum()
print(f"\nGenes with zero counts: {zero_genes}")
print(f"Genes with counts: {len(count_matrix) - zero_genes}")

# Save combined matrix
output_file = os.path.join(counts_dir, "combined_counts.csv")
count_matrix.to_csv(output_file)
print(f"\nSaved to: {output_file}")
EOF

echo ""
echo "Combined counts file:"
ls -lh $COUNT_DIR/combined_counts.csv

# Upload to bucket
echo ""
echo "Uploading combined counts to bucket..."
gcloud storage cp $COUNT_DIR/combined_counts.csv $BUCKET/counts/combined_counts.csv

echo "================================================"
echo "STEP 8 COMPLETE: Counts combined"
echo "File saved to: $BUCKET/counts/combined_counts.csv"
echo "================================================"
