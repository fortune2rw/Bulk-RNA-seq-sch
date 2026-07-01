#!bin/bash

prefetch SRR4933108 SRR4933109 SRR4933114 SRR4933115
echo "Downloading SRA files..."
echo "SRA files downloaded to PATH"

# Get fastqc file FOR SAMPLE1 
fasterq-dump $WORKDIR/SRR4933108/SRR4933108.sra --split-files --outdir $FASTQ_DIR

echo "SRA files converted to FASTQ"

mv $FASTQ_DIR/SRR4933108_1.fastq $FASTQ_DIR/CTRL1_1.fastq
echo "File renamed successfully"
