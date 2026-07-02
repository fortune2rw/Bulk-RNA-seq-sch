# Bulk RNA-seq Data Preprocessing Pipeline

This repo contains shell scripts for preprocessing raw bulk RNA-seq sequencing data. The workflow covers downloading sequencing data from the NCBI Sequence Read Archive (SRA), assessing read quality, trimming adapters and low-quality bases(optional), and aligning reads to the human reference genome.

The pipeline was developed and executed using **Google Cloud Platform (GCP)**, with **Google Cloud Storage** used to store sequencing data and a **Google Compute Engine virtual machine** used for processing.

---

## Dataset

The sequencing data were obtained from the **NCBI Gene Expression Omnibus (GEO)** dataset **GSE46562**.

Four samples were randomly selected for this project:

| Group | SRA Accession |
|--------|---------------|
| Schizophrenia | SRR4933114 |
| Schizophrenia | SRR4933115 |
| Control | SRR4933108 |
| Control | SRR4933109 |

---

## Pipeline Overview

```text
                NCBI GEO (GSE46562)
                         │
                         ▼
               Download SRA Files
                         │
                         ▼
             Convert SRA → FASTQ
                         │
                         ▼
          Quality Control (FastQC)
                         │
                         ▼
      Adapter & Quality Trimming
              (Trimmomatic)
                         │
                         ▼
      Build STAR Genome Index
        (GRCh38 Reference)
                         │
                         ▼
          Align Reads (STAR)
                         │
                         ▼
        Sorted BAM Files (.bam)
        + Alignment Statistics
```

---

## Computing Environment

This workflow was performed on **Google Cloud Platform (GCP)**.

- **Google Cloud Storage** was used to store raw sequencing data, intermediate files, and alignment outputs.
- **Google Compute Engine (VM)** was used to execute all preprocessing steps.

---

## Software

The following tools were used throughout the workflow:

- FastQC
- Trimmomatic
- STAR
- SRA Toolkit
- samtools

---

## Running the Pipeline

Install the required software:

```bash
bash scripts/installtools.sh
```

Configure the working environment:

```bash
bash scripts/setup-environment.sh
```

Download sequencing data from the SRA:

```bash
bash scripts/SRA-fastqfile.sh
```

Run quality control:

```bash
bash scripts/fastqc.run
```

Trim adapters and low-quality reads:

```bash
bash scripts/trimmomatic.run
```

Build the STAR genome index:

```bash
bash scripts/star_index.sh
```

Align reads to the GRCh38 reference genome:

```bash
bash scripts/star_alignment.run
```

---

## Output

The pipeline generates the following files:

- Raw FASTQ files
- FastQC reports
- Trimmed FASTQ files
- STAR genome index
- Coordinate-sorted BAM alignment files (`Aligned.sortedByCoord.out.bam`)
- Gene-level read count tables (`ReadsPerGene.out.tab`)
- Alignment summary statistics (`Log.final.out`)
- Detected splice junctions (`SJ.out.tab`)

## Reference 
- National Cancer Institute. *GDC Bioinformatics Pipeline: mRNA Analysis*. Available at: https://docs.gdc.cancer.gov/Data/Bioinformatics_Pipelines/Expression_mRNA_Pipeline/ (accessed 2 July 2026). :contentReference[oaicite:0]{index=0}
