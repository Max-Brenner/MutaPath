# MutaPath

AI-assisted bioinformatics platform that interprets genomic variants across DNA, transcript, protein, and pathway layers to generate mechanistic hypotheses about functional and metabolic consequences.

## Problem

Existing tools (VEP, SnpEff) annotate variants and predict protein effects but don't integrate these layers or provide mechanistic reasoning. Users manually connect outputs. MutaPath automates this.

## Core Use Case

Given a set of genomic variants, determine their likely biological consequences.

**Inputs:**
- VCF file + reference genome + GTF/GFF annotation
- Optional BED file (region filtering)
- Optional regulatory BED file (promoters, enhancers)

**Outputs:**
- Structured biological evidence (JSON)
- Pathway-level context
- AI-generated mechanistic interpretations (Markdown/HTML reports)

**Example output:**
> This missense mutation likely alters the catalytic domain of enzyme X, reducing its activity. Because this enzyme functions early in pathway Y, this may decrease production of metabolite Z and lead to accumulation of intermediate A.

## Architecture

```
Nextflow (workflow orchestration)
├── Input Layer        — bcftools (normalize, filter, index)
├── Annotation Layer   — VEP (consequences, protein effects, regulatory)
│                        bedtools (regulatory region intersect)
├── Protein Layer      — Python (parse VEP JSON for domain/motif info)
├── Context Layer      — Python (pathway mapping, metabolic flux inference)
├── Integration Layer  — Python (evidence_schema JSON assembly)
├── AI Layer           — LLM API (mechanistic hypothesis generation)
└── Output Layer       — Python (Markdown + HTML reports)
```

## Tool Stack

| Tool | Purpose |
|------|---------|
| `bcftools` | VCF normalization, filtering, indexing |
| `VEP` (Ensembl) | Variant consequence + protein + regulatory annotation |
| `bedtools` | Regulatory region intersection |
| Python | Protein parsing, pathway mapping, metabolic engine, evidence assembly, reporting |
| LLM API | Cross-layer mechanistic reasoning (Anthropic/OpenAI) |

## Usage

```bash
nextflow run nextflow/main.nf \
    --samplesheet assets/samplesheet.csv \
    --vep_cache /path/to/vep_cache \
    --outdir results
```

Optional params:
```bash
    --bed              /path/to/regions.bed        # filter to regions
    --regulatory_bed   /path/to/regulatory.bed     # regulatory intersect
```

Samplesheet format (`assets/samplesheet.csv`):
```csv
sample_id,vcf,reference,gtf
sample1,/path/to/sample1.vcf,/path/to/genome.fa,/path/to/annotation.gtf
```

Run with stubs (no real tools needed):
```bash
nextflow run nextflow/main.nf --samplesheet assets/samplesheet.csv -stub
```

## VEP Cache Setup

```bash
vep_install -a cf -s homo_sapiens -y GRCh38 -c /path/to/cache
```

## V1 Scope

**In scope:**
- VCF normalization, region filtering, quality filtering
- Full variant consequence annotation via VEP
- Protein domain/motif mapping
- Gene-to-pathway mapping, rule-based metabolic flux inference
- AI cross-layer synthesis with uncertainty reporting
- JSON evidence schema, Markdown/HTML reports

**Out of scope:**
- Variant calling from raw sequencing data
- Advanced splicing prediction, de novo protein structure prediction
- Flux balance analysis, clinical pathogenicity classification
- Multiomics integration (RNA, proteomics, metabolomics)
- Reverse design (variant generation)

## Target Users

Primary (V1): bioinformatics scientists, computational biologists, synthetic biology researchers.
