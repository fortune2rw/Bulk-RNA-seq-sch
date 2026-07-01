#!bin/bash
# Note: Requires ~32GB RAM and ~30GB disk
# Run on high memory VM (e2-highmem-8)

# Check available RAM
free -h
# Check available disk
df -h

# Download reference genome (GRCh38)
wget -p $GENOMEDIR \
    https://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
#Download annotation file 
wget -p $GENOMEDIR \
    https://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz

#Decompress both zip file
gunzip $GENOME_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
gunzip $GENOME_DIR/Homo_sapiens.GRCh38.109.gtf.gz


#Build Star Index, This takes about 40 minutes
STAR --runMode genomeGenerate \
    --genomeDir $INDEX_DIR \
    --genomeFastaFiles $GENOME_DIR/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
    --sjdbGTFfile $GENOME_DIR/Homo_sapiens.GRCh38.109.gtf \
    --runThreadN 4
