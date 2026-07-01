#!/bin/bash

set -e
set -u 

-------------- Variable ------------

BUCKET="gs://schzrophenia"
SAMPLES=("CTRL1" "CTRL2" "SAMPLE1" "SAMPLE2")
WORKDIR="$HOME"
FASTQ_DIR="$WORKDIR/fastq"
TRIMMED_DIR="$WORKDIR/trimmed"
FASTQC_DIR="$WORKDIR/fastqc_results"
FASTQC_TRIMMED_DIR="$WORKDIR/fastqc_trimmed"
STAR_DIR="$WORKDIR/STAR"
GENOME_DIR="$STAR_DIR/genome"
INDEX_DIR="$STAR_DIR/index"
OUTPUT_DIR="$STAR_DIR/output"
COUNTS_DIR="$WORKDIR/counts"
RESULTS_DIR="$WORKDIR/results"
TRIMMOMATIC_JAR="/usr/share/java/trimmomatic.jar"

-------------- Directories --------------
mkdir -p $FASTQ_DIR
mkdir -p $TRIMMED_DIR
mkdir -p $FASTQC_DIR
mkdir -p $FASTQC_TRIMMED_DIR
mkdir -p $GENOME_DIR
mkdir -p $INDEX_DIR
mkdir -p $OUTPUT_DIR
mkdir -p $COUNTS_DIR
mkdir -p $RESULTS_DIR

echo "Directories Created Successfully!"

