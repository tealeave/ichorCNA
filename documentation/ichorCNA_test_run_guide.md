# ichorCNA Reproducible Test Run Guide

## Overview

**Purpose:** Validate ichorCNA Docker installation using included sample data  
**Genome Build:** hg19 (GRCh37)  
**Bin Size:** 1Mb (1000kb)  
**Sample:** MBC_315 (Metastatic Breast Cancer cfDNA sample)  
**Date Created:** December 2024

---

## Part 1: Docker Setup and Fix

### Problem

The official `fredhutch/ichorcna:latest` Docker image has two issues:
1. Missing the `optparse` R package, which is required by `runIchorCNA.R`
2. Version mismatch between the installed ichorCNA package (v0.5.0) and the repository scripts (v0.3.2)

### Solution: Build Fixed Docker Image

#### Step 1: Create Fixed Dockerfile

```bash
cat > ~/projects/ichorCNA/Dockerfile << 'EOF'
FROM fredhutch/ichorcna:latest

RUN Rscript -e "install.packages('optparse', repos='https://cloud.r-project.org')"

WORKDIR /ichorCNA
EOF
```

#### Step 2: Build Custom Image

```bash
cd ~/projects/ichorCNA
docker build -t ichorcna-custom .
```

#### Step 3: Verify Installation

```bash
docker run --rm -v /home/ubuntu/projects/ichorCNA:/ichorCNA ichorcna-custom \
  Rscript /ichorCNA/scripts/runIchorCNA.R --help
```

Expected output: List of all available command-line options for ichorCNA.

### Important Notes

- **Use `--libdir /ichorCNA`**: Due to version mismatch between the Docker image's ichorCNA package (v0.5.0) and the repository (v0.3.2), you must use the `--libdir` parameter to source the local R files.
- **Use `--genomeStyle UCSC`**: The NCBI genome style requires network access to UCSC servers for chromosome name mapping. Using UCSC style avoids this network dependency.

---

## Part 2: Input Files Inventory

All files are included in the repository under `inst/extdata/`:

### Sample Data (WIG files)

| File | Description |
|------|-------------|
| `MBC_315.ctDNA.reads.wig` | Primary test sample - cfDNA read counts (1Mb bins) |
| `MBC_315_T2.ctDNA.reads.wig` | Secondary sample (can use for additional testing) |

### Reference Files (hg19, 1Mb bins)

| File | Description |
|------|-------------|
| `gc_hg19_1000kb.wig` | GC content for each 1Mb bin |
| `map_hg19_1000kb.wig` | Mappability scores for each 1Mb bin |
| `GRCh37.p13_centromere_UCSC-gapTable.txt` | Centromere locations |
| `HD_ULP_PoN_1Mb_median_normAutosome_mapScoreFiltered_median.rds` | Panel of Normals (healthy donor cfDNA) |

### Alternative Reference Files Available

- **hg38:** `gc_hg38_*.wig`, `map_hg38_*.wig`, `GRCh38.GCA_000001405.2_centromere_acen.txt`, `HD_ULP_PoN_hg38_*.rds`
- **Other bin sizes:** 10kb, 50kb, 500kb versions also included

---

## Part 3: R Dependencies

Required R packages (included in Docker):

```
R >= 3.6.0
ichorCNA >= 0.3.2
HMMcopy >= 1.14.0
GenomicRanges >= 1.36.0
GenomeInfoDb >= 1.20.0
plyr >= 1.8.4
optparse (added via Dockerfile fix)
```

---

## Part 4: Test Run Steps

### Step 1: Create Output Directory

```bash
mkdir -p /home/ubuntu/projects/ichorCNA/test_output
```

### Step 2: Run ichorCNA with Sample Data

```bash
docker run --rm \
  -v /home/ubuntu/projects/ichorCNA:/ichorCNA \
  ichorcna-custom \
  Rscript /ichorCNA/scripts/runIchorCNA.R \
    --libdir /ichorCNA \
    --id MBC_315 \
    --WIG /ichorCNA/inst/extdata/MBC_315.ctDNA.reads.wig \
    --ploidy "c(2)" \
    --normal "c(0.5)" \
    --maxCN 5 \
    --gcWig /ichorCNA/inst/extdata/gc_hg19_1000kb.wig \
    --mapWig /ichorCNA/inst/extdata/map_hg19_1000kb.wig \
    --centromere /ichorCNA/inst/extdata/GRCh37.p13_centromere_UCSC-gapTable.txt \
    --normalPanel /ichorCNA/inst/extdata/HD_ULP_PoN_1Mb_median_normAutosome_mapScoreFiltered_median.rds \
    --includeHOMD False \
    --chrs "c(1:22, \"X\")" \
    --chrTrain "c(1:22)" \
    --estimateNormal True \
    --estimatePloidy True \
    --estimateScPrevalence False \
    --txnE 0.9999 \
    --txnStrength 10000 \
    --genomeBuild hg19 \
    --genomeStyle UCSC \
    --outDir /ichorCNA/test_output/
```

**Key parameters for Docker compatibility:**
- `--libdir /ichorCNA`: Uses local R source files instead of installed package
- `--genomeStyle UCSC`: Avoids network dependency for chromosome name mapping

---

## Part 5: Parameter Explanation

| Parameter | Value | Description |
|-----------|-------|-------------|
| `--libdir` | /ichorCNA | Path to local R source files (required for Docker) |
| `--id` | MBC_315 | Sample identifier for output files |
| `--WIG` | Sample WIG file | Read counts per bin |
| `--ploidy` | c(2) | Initial ploidy values to test |
| `--normal` | c(0.5) | Initial normal contamination values |
| `--maxCN` | 5 | Maximum copy number state |
| `--gcWig` | GC content file | For GC bias correction |
| `--mapWig` | Mappability file | For mappability bias correction |
| `--centromere` | Centromere file | Exclude centromeric regions |
| `--normalPanel` | Panel of Normals | Median from healthy donors for normalization |
| `--includeHOMD` | False | Exclude homozygous deletions (good for 1Mb bins) |
| `--chrs` | c(1:22, "X") | Chromosomes to analyze |
| `--chrTrain` | c(1:22) | Chromosomes to train model (exclude X) |
| `--estimateNormal` | True | Estimate normal contamination |
| `--estimatePloidy` | True | Estimate tumor ploidy |
| `--estimateScPrevalence` | False | Estimate subclonal prevalence (disabled for basic test) |
| `--txnE` | 0.9999 | Self-transition probability (higher = fewer segments) |
| `--txnStrength` | 10000 | Transition pseudo-counts |
| `--genomeBuild` | hg19 | Genome build version |
| `--genomeStyle` | UCSC | Chromosome naming (UCSC=chr1,chr2,chr3; avoids network dependency) |

**Note:** For a more thorough analysis with multiple solutions, you can expand `--ploidy` to `"c(2,3)"` and `--normal` to `"c(0.5,0.6,0.7,0.8,0.9)"`, but this requires more computation time.

---

## Part 6: Expected Output Files

After successful run, you should find in `test_output/`:

| File | Description |
|------|-------------|
| `MBC_315.seg` | Segments (IGV compatible) |
| `MBC_315.seg.txt` | Segments with subclonal status |
| `MBC_315.cna.seg` | Bin-level copy number estimates |
| `MBC_315.params.txt` | Final parameters and all solutions |
| `MBC_315.correctedDepth.txt` | GC/mappability corrected log2 ratios |
| `MBC_315.RData` | R session image |
| `MBC_315/` | Directory with plots |

### Plot Files (in `MBC_315/` subdirectory)

| File | Description |
|------|-------------|
| `MBC_315_genomeWide.pdf` | Genome-wide CNA plot (optimal solution) |
| `MBC_315_genomeWide_all_sols.pdf` | All solutions ranked by likelihood |
| `MBC_315_genomeWide_n*-p*.pdf` | Individual solution plots |
| `MBC_315_CNA_chr*.pdf` | Per-chromosome plots |
| `MBC_315_bias.pdf` | Bias correction visualization |
| `MBC_315_correct.pdf` | Before/after correction comparison |
| `MBC_315_tpdf.pdf` | Copy number state distributions |

---

## Part 7: Validation Checklist

After the run completes:

- [ ] Check exit code is 0 (success)
- [ ] Verify `MBC_315.params.txt` exists and contains tumor fraction estimate
- [ ] Verify `MBC_315/MBC_315_genomeWide.pdf` plot is generated
- [ ] Check log output shows "Total ULP-WGS HMM Runtime: X min."
- [ ] Open genome-wide plot to confirm CNA segments are visualized

### Quick Validation Commands

```bash
# Check if key output files exist
ls -la /home/ubuntu/projects/ichorCNA/test_output/MBC_315.params.txt
ls -la /home/ubuntu/projects/ichorCNA/test_output/MBC_315/MBC_315_genomeWide.pdf

# View tumor fraction estimate
grep "Tumor Fraction" /home/ubuntu/projects/ichorCNA/test_output/MBC_315.params.txt
```

---

## Part 8: Understanding the Output

### Key Parameters in `MBC_315.params.txt`

| Parameter | Description |
|-----------|-------------|
| **Tumor Fraction** | Estimated fraction of tumor-derived DNA (equivalent to purity) |
| **Tumor Ploidy** | Average copy number of tumor genome |
| **Subclone Fraction** | Fraction of tumor DNA that is subclonal |
| **Fraction Genome Subclonal** | Proportion of bins with subclonal events |
| **Fraction CNA Subclonal** | Proportion of CNA bins that are subclonal |
| **n_est** | Estimated normal fraction (1 - tumor fraction) |
| **phi_est** | Estimated tumor ploidy |
| **loglik** | Log-likelihood of each solution |

### Interpreting Genome-Wide Plots

- **Data points:** Log2 ratio copy number for each bin (corrected for GC and mappability)
- **Colors indicate copy number:**
  - Dark green = 1 copy (deletion)
  - Blue = 2 copies (neutral/diploid)
  - Brown = 3 copies (gain)
  - Red = 4+ copies (amplification)
  - Light green segments = subclonal events
- **Horizontal lines:** Segment medians

---

## Part 9: Troubleshooting

### Common Issues

1. **Missing optparse package**
   - Solution: Use the fixed Docker image (see Part 1)

2. **"Error in lambdas[, , i]" or EM initialization errors**
   - Solution: Use `--libdir /ichorCNA` to use local R source files
   - This is caused by version mismatch between Docker package (v0.5.0) and repo scripts (v0.3.2)

3. **"cannot open URL 'http://hgdownload.cse.ucsc.edu/...'"**
   - Solution: Use `--genomeStyle UCSC` instead of `NCBI`
   - The NCBI style requires network access to UCSC for chromosome name mapping
   - UCSC style works offline using BSgenome package

4. **Cairo/graphics errors**
   - The script sets `options(bitmapType='cairo')` automatically
   - If issues persist, check X11 forwarding or use `--plotFileType png`

5. **Memory issues**
   - 1Mb bins require minimal memory (~2GB)
   - For 10kb bins, increase Docker memory limit

6. **Permission denied on output**
   - Ensure output directory is writable
   - Check Docker volume mount permissions

7. **Chromosome naming issues**
   - Use `--genomeStyle UCSC` for chr1,chr2,chr3 format (recommended for Docker)
   - Use `--genomeStyle NCBI` for 1,2,3 format (requires network access)

---

## Part 10: Running with Your Own Data

### Step 1: Generate WIG File from BAM

Use HMMcopy's `readCounter` tool:

```bash
readCounter --window 1000000 --quality 20 \
  --chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" \
  /path/to/your_sample.bam > /path/to/your_sample.wig
```

**Note:** BAM file must be indexed (`.bam.bai` file required).

### Step 2: Run ichorCNA

Replace the sample WIG path with your own file in the command from Part 4.

---

## Part 11: Official Documentation References

- **Wiki Home:** https://github.com/broadinstitute/ichorCNA/wiki
- **Installation:** https://github.com/broadinstitute/ichorCNA/wiki/Installation
- **Usage:** https://github.com/broadinstitute/ichorCNA/wiki/Usage
- **Output Interpretation:** https://github.com/broadinstitute/ichorCNA/wiki/Output
- **Parameter Tuning:** https://github.com/broadinstitute/ichorCNA/wiki/Parameter-tuning-and-settings
- **Panel of Normals:** https://github.com/broadinstitute/ichorCNA/wiki/Create-Panel-of-Normals
- **Snakemake Pipeline:** https://github.com/broadinstitute/ichorCNA/wiki/SnakeMake-pipeline-for-ichorCNA
- **FAQ:** https://github.com/broadinstitute/ichorCNA/wiki/FAQ

---

## Part 12: Verified Test Run Results

This test was run on December 9, 2024 and completed successfully.

### Expected Output

```
Total ULP-WGS HMM Runtime: 0.082 min.
Writing segments to /ichorCNA/test_output//MBC_315.seg
Outputting to bin-level results to /ichorCNA/test_output//MBC_315.cna.seg
```

### Sample Results from MBC_315.params.txt

```
Sample          Tumor Fraction  Ploidy
MBC_315         0.255           1.898

Gender:                     female
Tumor Fraction:             0.255
Ploidy:                     1.898
Subclone Fraction:          NA
Fraction Genome Subclonal:  0
Fraction CNA Subclonal:     0
```

### Generated Files

| File | Size | Description |
|------|------|-------------|
| MBC_315.params.txt | 518 B | Analysis parameters |
| MBC_315.seg | 2.7 KB | Segments (IGV compatible) |
| MBC_315.seg.txt | 4.1 KB | Segments with details |
| MBC_315.cna.seg | 161 KB | Bin-level results |
| MBC_315.correctedDepth.txt | 108 KB | Corrected depth |
| MBC_315.RData | 870 KB | R session data |
| MBC_315_genomeWide.pdf | 140 KB | Main genome plot |
| MBC_315_bias.pdf | 614 KB | Bias correction plots |

---

## Appendix: File Locations Summary

```
/home/ubuntu/projects/ichorCNA/
├── Dockerfile                    # Fixed Docker build file
├── scripts/
│   └── runIchorCNA.R            # Main analysis script
├── inst/extdata/
│   ├── MBC_315.ctDNA.reads.wig  # Sample data
│   ├── gc_hg19_1000kb.wig       # GC content reference
│   ├── map_hg19_1000kb.wig      # Mappability reference
│   ├── GRCh37.p13_centromere_UCSC-gapTable.txt  # Centromeres
│   └── HD_ULP_PoN_1Mb_median_normAutosome_mapScoreFiltered_median.rds  # PoN
├── test_output/                  # Output directory (created)
│   ├── MBC_315.params.txt
│   ├── MBC_315.seg
│   ├── MBC_315.cna.seg
│   └── MBC_315/                  # Plots subdirectory
└── documentation/
    └── ichorCNA_test_run_guide.md  # This file
```
