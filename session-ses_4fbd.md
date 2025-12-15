# Creating ichorCNA-inno tarball

**Session ID:** ses_4fbd919b0ffeJeCa1u4WIe2Qsp
**Created:** 12/9/2025, 5:26:56 PM
**Updated:** 12/15/2025, 7:42:21 PM

---

## User

let's create a tarball called ichorCNA-inno from /home/ubuntu/projects/ichorCNA-inno . I am sharing this tar to my teammate

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Done! The tarball has been created at `/home/ubuntu/projects/ichorCNA-inno.tar.gz`.

```
Tool: bash
```

---

## Assistant

The tarball is ready to share:

- **Location:** `/home/ubuntu/projects/ichorCNA-inno.tar.gz`
- **Size:** 8.5 MB

Your teammate can extract it with:
```bash
tar -xzvf ichorCNA-inno.tar.gz
```

---

## User

ok I generated some new file, let's rync /home/ubuntu/projects/ichorCNA to /home/ubuntu/projects/ichorCNA-inno again. Remember to skip the git related file and reports/

---

## Assistant

```
Tool: bash
```

---

## Assistant

Done! Synced `/home/ubuntu/projects/ichorCNA/` to `/home/ubuntu/projects/ichorCNA-inno/`, excluding `.git*` files and `reports/` directory.

New file synced: `test_output/ichorCNA_run.log`

---

## User

let's tar it up again

---

## Assistant

```
Tool: bash
```

---

## Assistant

Done! Updated tarball created:

- **Location:** `/home/ubuntu/projects/ichorCNA-inno.tar.gz`
- **Size:** 8.5 MB (now includes `ichorCNA_run.log`)

---

## User

write donw what we have done as a report - ref '/home/ubuntu/projects/CNV_callers/ichorCNA/documentation/reports/report_guuide.md'

---

## Assistant

```
Tool: read
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: write
```

---

## Assistant

```
Tool: write
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Done! Report has been saved.

---

**MANIFEST**

```
saved_dir: documentation/reports/2025-12-15/ichorcna-tarball-sharing-2025-12-15/
files:
  - report.md      (3239 bytes)
  - results.csv    (179 bytes)
```

Open: `documentation/reports/2025-12-15/ichorcna-tarball-sharing-2025-12-15/report.md`

Note: JSON block was skipped per the guide since no models were generated in this session.

---

## User

great, next we want to compare the docker container diferennce between the one we implemented here and gavinhalab/ichorcna:3.0.0. We need to pick one, let's compare them 

---

## Assistant

---

## User

ok continue

---

## User

ok continue

---

## Assistant

I'll help you compare the two Docker containers. Let me first examine the Dockerfile we have here and then look at the gavinhalab/ichorcna:3.0.0 image.

```
Tool: read
```

```
Tool: read
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Let me pull and inspect the gavinhalab image to compare:

```
Tool: bash
```

---

## Assistant

Now let me compare the two images in detail:

```
Tool: bash
```

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Interesting finding! Let me check a few more things:

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

Now I have a comprehensive comparison. Here's my analysis:

---

## Docker Container Comparison Summary

| Attribute | **ichorcna-custom (ours)** | **gavinhalab/ichorcna:3.0.0** |
|-----------|---------------------------|------------------------------|
| **Image Size** | 3.44 GB | 3.67 GB |
| **Base Image** | fredhutch/ichorcna:latest → Debian bookworm | rocker/r-ver:4.2.2 → Ubuntu 22.04 |
| **Age** | 6 days old (custom layer) | 3 months old |
| **R Version** | 4.2.2 | 4.2.2 |
| **ichorCNA Version** | **0.5.0** | **0.5.1** (newer) |
| **Total R Packages** | 204 | 178 |
| **optparse** | ✅ Installed (1.7.5) | ❌ **NOT installed** |
| **hmmcopy_utils** | ✅ readCounter available | ✅ readCounter available |
| **extdata files** | 43 files | 43 files (same) |

### Key Package Versions

| Package | **Ours** | **Gavinhalab** |
|---------|----------|----------------|
| ichorCNA | 0.5.0 | 0.5.1 |
| BSgenome | 1.66.1 | 1.66.3 |
| BSgenome.Hsapiens.UCSC.hg38 | 1.4.4 | 1.4.5 |
| data.table | 1.14.6 | 1.17.8 |
| GenomicRanges | 1.50.1 | 1.50.2 |
| ggplot2 | 3.4.0 | 3.5.2 |
| HMMcopy | 1.40.0 | 1.40.0 |

---

## Key Differences

### 1. **ichorCNA Version**
- Ours: v0.5.0 (from Dec 2022)
- Gavinhalab: v0.5.1 (from Nov 2024) - **newer**

### 2. **optparse Package**
- Ours: ✅ **Installed** - required to run `runIchorCNA.R` script
- Gavinhalab: ❌ **Missing** - will fail when running the main script!

### 3. **Package Freshness**
- Gavinhalab has newer versions of several packages (data.table, ggplot2, BSgenome)
- Our image is based on 3-year-old fredhutch base

### 4. **Base OS**
- Ours: Debian bookworm/sid
- Gavinhalab: Ubuntu 22.04 LTS (more stable for production)

---

## Recommendation

**For immediate use: Choose `ichorcna-custom` (ours)**

Reasons:
1. **optparse is pre-installed** - critical for running `runIchorCNA.R`
2. Smaller image size (3.44 GB vs 3.67 GB)
3. Already tested with your workflow

**However**, if you want the latest ichorCNA (0.5.1) with newer packages, you could:
1. Use `gavinhalab/ichorcna:3.0.0` as base
2. Add optparse installation layer (like we did)

Would you like me to:
1. Create a plan to build a new image based on gavinhalab with optparse added?
2. Stick with our current `ichorcna-custom` image?
3. Investigate what changed between ichorCNA 0.5.0 and 0.5.1?

---

## User

I have also heard that the gavin's repo where he generated the container has 20+ commits on top of the base repo (think the fredhutch just used the base?). What does these new commits do? My colleague said Gavin's ichor will create a lot of the "solutions" folder? What is the structure and what are those folders? What does "optimal solution" mean? Let's figure it out.

---

## Assistant

I'll investigate the GavinHaLab ichorCNA repository to understand the differences and what these "solutions" folders are about.

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Now let me look at the key differences in the output structure, particularly the "solutions" folders:

```
Tool: bash
```

---

## Assistant

```
Tool: read
```

---

## Assistant

Now let me look at the output.R to see how solutions are saved:

```
Tool: read
```

---

## Assistant

Now let me check the scripts directory in both repos for the main runIchorCNA.R script:

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

```
Tool: read
```

---

## Assistant

Let me check for the "solutions" folder creation in the broader runIchorCNA script:

```
Tool: bash
```

---

## Assistant

Now let me examine the actual test output structure from our local run and understand the differences:

```
Tool: bash
```

```
Tool: bash
```

---

## User

here is the fredhutch repo: https://github.com/FredHutch/ichorcna-docker/blob/master/Dockerfile . For gavinhalab - gavinhalab/ichorcna:3.0.0

---

## Assistant

```
Tool: webfetch
```

```
Tool: webfetch
```

---

## Assistant

Let me get the raw Dockerfile content:

```
Tool: webfetch
```

```
Tool: webfetch
```

---

## Assistant

Now let me compare the commit differences between the two repos to understand what GavinHaLab added:

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Now let me look at the key differences - especially what "solutions" are and how they're generated. Let me look at the plotting.R which has the solution plotting logic:

```
Tool: bash
```

```
Tool: bash
```

---

## Assistant

Let me understand the "solutions" concept better by examining the key logic:

```
Tool: read
```

---

## Assistant

Now I have a clear picture. Let me read the .params.txt file from our test output to see what solutions look like:

```
Tool: read
```

---

## Assistant

Now I have a comprehensive understanding. Let me summarize this for you:

---

## Summary: Docker Container & Repository Comparison

### Repository Lineage

```
broadinstitute/ichorCNA (original) 
    ↓ fork
GavinHaLab/ichorCNA (+57 commits, active maintenance)
    ↓ uses
gavinhalab/ichorcna:3.0.0 Docker image

fredhutch/ichorcna-docker (uses broadinstitute code)
    ↓ base for
ichorcna-custom (our image)
```

### Key Findings

#### 1. **FredHutch Dockerfile** (what our `ichorcna-custom` is based on)
```dockerfile
FROM r-base:3.6.2
# Uses broadinstitute/ichorCNA (original repo)
RUN git clone https://github.com/broadinstitute/ichorCNA.git
RUN R CMD INSTALL ichorCNA
```
- Uses **R 3.6.2** (old)
- Installs from **broadinstitute** (original, less maintained)
- ichorCNA version **0.5.0** (from 2022)

#### 2. **GavinHaLab Repository** (57+ commits ahead of broadinstitute)

Key improvements in GavinHaLab fork:
| Commit | Description |
|--------|-------------|
| `e333f7e` | Add missing function and dependencies |
| `267cf3c` | **Depend on R-4.2 for hg38 to work** |
| `549c487` | Improve error messaging on required wig params |
| `f67f8f5` | Add null default for normal_wig to allow unpaired runs |
| `814c342` | **New PoN for hg38** - fixed panel of normals |
| `7e9f6b0` | **Add replication timing wig files** |
| `0870faa` | **chrX normalization** - exposed normalizeMaleX argument |
| `1ef112f` | **Parallelization** - foreach/doMC for E-step by chromosome |
| `3102297` | Added subclone penalty; tuned Gaussian likelihood |

---

### What are "Solutions"?

**ichorCNA generates multiple "solutions"** because the HMM model runs with different initial parameters (normal contamination `n` and ploidy `p` combinations). Each combination produces a different solution.

#### How Solutions Work:

1. **Initial Parameters Grid:**
   ```
   normal = c(0.5, 0.6, 0.7, 0.8, 0.9, 0.95)  # normal contamination
   ploidy = c(2, 3, 4)                          # tumor ploidy
   ```

2. **For each combination**, the HMM runs and estimates:
   - Tumor fraction
   - Ploidy
   - Copy number segments
   - Log-likelihood (how well the model fits the data)

3. **Solutions are ranked** by:
   - Highest log-likelihood (best fit)
   - Excluding solutions with too high subclonal fraction

4. **"Optimal Solution"** = the solution with the highest likelihood that passes quality filters

#### Output Structure (per sample):

```
test_output/
├── MBC_315.params.txt          # Parameters for OPTIMAL solution
├── MBC_315.seg                 # Segments for optimal solution
├── MBC_315.seg.txt             # Detailed segments
├── MBC_315.cna.seg             # Bin-level CNA calls
├── MBC_315.correctedDepth.txt  # Corrected read counts
├── MBC_315.RData               # All solutions stored here
└── MBC_315/                    # Plot directory
    ├── MBC_315_genomeWide.pdf              # Optimal solution plot
    ├── MBC_315_genomeWide_all_sols.pdf     # ALL solutions combined
    ├── MBC_315_genomeWide_n0.5-p2.pdf      # Individual solution (n=0.5, p=2)
    ├── MBC_315_genomeWide_n0.5-p3.pdf      # Individual solution (n=0.5, p=3)
    ├── MBC_315_CNA_chrchr1.pdf             # Per-chromosome plots
    └── ...
```

#### From your params.txt:
```
init       n_est  phi_est  loglik
n0.5-p2    0.75   1.898    3411    ← Only 1 solution run (default)
```

Your run used only `--normal 0.5 --ploidy 2`, so only 1 solution was generated.

---

### "Solutions Folders" Your Colleague Mentioned

If you run with **multiple normal/ploidy combinations**, you get more files:
```bash
--normal "c(0.2,0.35,0.5,0.6,0.7,0.8,0.9,0.95)" --ploidy "c(2,3,4)"
```

This would generate **up to 24 solutions** (8 normal × 3 ploidy), each with its own genome-wide plot in the sample folder.

---

### Recommendation

**For production use, I recommend `gavinhalab/ichorcna:3.0.0` with optparse added** because:

1. ✅ **Newer ichorCNA (0.5.1)** with bug fixes
2. ✅ **R 4.2.2** required for hg38 support
3. ✅ **Fixed hg38 Panel of Normals**
4. ✅ **Parallelization support**
5. ✅ **Better error handling**
6. ❌ **Missing optparse** - needs to be added

Would you like me to:
1. **Create a new Dockerfile** based on `gavinhalab/ichorcna:3.0.0` + optparse?
2. **Run a test with multiple solutions** to see the full output structure?
3. **Document the differences** in a formal report?

---

## User

'/home/ubuntu/projects/CNV_callers/ichorCNA/documentation/image.png' here is the container comparison. Here is gavin's repo https://github.com/broadinstitute/ichorCNA/compare/master...GavinHaLab:ichorCNA:master . Here is the folder structure that it created: (base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ ls
NTC_genomeWide_all_sols.pdf  NTC_genomeWide_n0.5-p3.pdf  NTC_genomeWide_n0.6-p3.pdf  NTC_genomeWide_n0.7-p3.pdf  NTC_genomeWide_n0.8-p3.pdf  NTC_genomeWide_n0.9-p3.pdf  solution_n0.6_p2  solution_n0.7_p2  solution_n0.8_p2  solution_n0.9_p2  solution_optimal_n0.5_p2
NTC_genomeWide_n0.5-p2.pdf   NTC_genomeWide_n0.6-p2.pdf  NTC_genomeWide_n0.7-p2.pdf  NTC_genomeWide_n0.8-p2.pdf  NTC_genomeWide_n0.9-p2.pdf  solution_n0.5_p3            solution_n0.6_p3  solution_n0.7_p3  solution_n0.8_p3  solution_n0.9_p3
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ ls -hal
total 2.8M
drwxr-xr-x 12 ssm-user ssm-user 4.0K Dec 14 18:39 .
drwxrwxr-x  4 ssm-user ssm-user 4.0K Dec 14 23:02 ..
-rw-r--r--  1 ssm-user ssm-user 1.4M Dec 14 18:38 NTC_genomeWide_all_sols.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:36 NTC_genomeWide_n0.5-p2.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:37 NTC_genomeWide_n0.5-p3.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:36 NTC_genomeWide_n0.6-p2.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:38 NTC_genomeWide_n0.6-p3.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:37 NTC_genomeWide_n0.7-p2.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:38 NTC_genomeWide_n0.7-p3.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:37 NTC_genomeWide_n0.8-p2.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:38 NTC_genomeWide_n0.8-p3.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:37 NTC_genomeWide_n0.9-p2.pdf
-rw-r--r--  1 ssm-user ssm-user 138K Dec 14 18:38 NTC_genomeWide_n0.9-p3.pdf
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.5_p3
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:38 solution_n0.6_p2
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.6_p3
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:38 solution_n0.7_p2
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.7_p3
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:38 solution_n0.8_p2
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.8_p3
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.9_p2
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:39 solution_n0.9_p3
drwxr-xr-x  3 ssm-user ssm-user 4.0K Dec 14 18:38 solution_optimal_n0.5_p2
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ ls solution_optimal_n0.5_p2
NTC  NTC.cna.seg  NTC.params.txt  NTC.seg  NTC.seg.txt
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ ls solution_optimal_n0.5_p2/NTC
NTC_CNA_chrchr1.pdf   NTC_CNA_chrchr14.pdf  NTC_CNA_chrchr19.pdf  NTC_CNA_chrchr3.pdf  NTC_CNA_chrchr8.pdf         NTC_correction_chrchr10.pdf  NTC_correction_chrchr15.pdf  NTC_correction_chrchr2.pdf   NTC_correction_chrchr4.pdf  NTC_correction_chrchr9.pdf
NTC_CNA_chrchr10.pdf  NTC_CNA_chrchr15.pdf  NTC_CNA_chrchr2.pdf   NTC_CNA_chrchr4.pdf  NTC_CNA_chrchr9.pdf         NTC_correction_chrchr11.pdf  NTC_correction_chrchr16.pdf  NTC_correction_chrchr20.pdf  NTC_correction_chrchr5.pdf  NTC_correction_chrchrX.pdf
NTC_CNA_chrchr11.pdf  NTC_CNA_chrchr16.pdf  NTC_CNA_chrchr20.pdf  NTC_CNA_chrchr5.pdf  NTC_CNA_chrchrX.pdf         NTC_correction_chrchr12.pdf  NTC_correction_chrchr17.pdf  NTC_correction_chrchr21.pdf  NTC_correction_chrchr6.pdf  NTC_genomeWide.pdf
NTC_CNA_chrchr12.pdf  NTC_CNA_chrchr17.pdf  NTC_CNA_chrchr21.pdf  NTC_CNA_chrchr6.pdf  NTC_bias.pdf                NTC_correction_chrchr13.pdf  NTC_correction_chrchr18.pdf  NTC_correction_chrchr22.pdf  NTC_correction_chrchr7.pdf  NTC_genomeWideCorrection.pdf
NTC_CNA_chrchr13.pdf  NTC_CNA_chrchr18.pdf  NTC_CNA_chrchr22.pdf  NTC_CNA_chrchr7.pdf  NTC_correction_chrchr1.pdf  NTC_correction_chrchr14.pdf  NTC_correction_chrchr19.pdf  NTC_correction_chrchr3.pdf   NTC_correction_chrchr8.pdf  NTC_tpdf.pdf
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ cd..
cd..: command not found
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ ls
NTC_genomeWide_all_sols.pdf  NTC_genomeWide_n0.5-p3.pdf  NTC_genomeWide_n0.6-p3.pdf  NTC_genomeWide_n0.7-p3.pdf  NTC_genomeWide_n0.8-p3.pdf  NTC_genomeWide_n0.9-p3.pdf  solution_n0.6_p2  solution_n0.7_p2  solution_n0.8_p2  solution_n0.9_p2  solution_optimal_n0.5_p2
NTC_genomeWide_n0.5-p2.pdf   NTC_genomeWide_n0.6-p2.pdf  NTC_genomeWide_n0.7-p2.pdf  NTC_genomeWide_n0.8-p2.pdf  NTC_genomeWide_n0.9-p2.pdf  solution_n0.5_p3            solution_n0.6_p3  solution_n0.7_p3  solution_n0.8_p3  solution_n0.9_p3
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test/NTC$ cd ..
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test$ ls
NTC  NTC.RData  NTC.correctedDepth.txt  NTC.markdup.wig  NTC2
(base) ssm-user@ip-10-175-147-77:~/containers/ichorcna/test$ . My colleague mentioned that in the WDL script for AWS healthomics, he use "solution_optimal_*" to try to get all the files in optimized param but got error. 1. Examine if gavin's new feature helps 2. Any thoughts on why solution_optimal_* threw an error on AWS OMICS?

---

## Assistant

Let me examine the image and the GitHub comparison to understand the differences better.

```
Tool: read
```

```
Tool: webfetch
```

---

## Assistant

Excellent! Now I can see the Docker Hub comparison image clearly. Let me search for the WDL script and understand the solution folder structure better.

```
Tool: webfetch
```

```
Tool: bash
```

---

## Assistant

```
Tool: webfetch
```

---

## Assistant

Now let me look at the Docker folder in the WDL repo to find the Dockerfile that creates the solution folders:

```
Tool: webfetch
```

---

## Assistant

Now I see the container uses ichorCNA v0.6.0! Let me check the v0.6.0 release notes and the specific changes that create the `solution_*` folders:

```
Tool: webfetch
```

---

## Assistant

Now let me look at the v0.6.0 code to see the solution folder creation:

```
Tool: webfetch
```

---

## Assistant

Now I found it! Let me create a comprehensive analysis. Looking at lines 450-485 in the v0.6.0 code:

---

## Comprehensive Analysis

### 1. What GavinHaLab v0.6.0 Changed (Solution Folders Feature)

The key new feature is in **lines 450-485** of `runIchorCNA.R`:

```r
# Loop through and output plots and results for each solution
for (i in 1:length(ind)){
  # Extract the corresponding purity and ploidy for this solution
  n_0 = loglik[[ ind[i], "n_0" ]]
  phi_0 = loglik[[ ind[i], "phi_0" ]]
  
  # Name the optimal solution folder with the optimal tag
  if (i == 1){
    solution = "/solution_optimal_n"  # ← OPTIMAL gets special prefix!
  }else{
    solution = "/solution_n"
  }
  
  # Create subfolders to hold each solution
  dir.create(paste0(outDir, "/", id, solution, n_0, "_p", phi_0, "/"))
  dir.create(paste0(outDir, "/", id, solution, n_0, "_p", phi_0, "/", id, "/"))
  ...
}
```

This creates the folder structure your colleague showed:

```
NTC/
├── NTC_genomeWide_all_sols.pdf
├── NTC_genomeWide_n0.5-p2.pdf
├── NTC_genomeWide_n0.5-p3.pdf
├── ...
├── solution_optimal_n0.5_p2/    ← OPTIMAL solution (ranked #1)
│   ├── NTC.cna.seg
│   ├── NTC.params.txt
│   ├── NTC.seg
│   ├── NTC.seg.txt
│   └── NTC/
│       ├── NTC_bias.pdf
│       ├── NTC_genomeWide.pdf
│       ├── NTC_CNA_chrchr1.pdf
│       ├── NTC_correction_chrchr1.pdf  ← NEW: correction plots
│       └── ...
├── solution_n0.5_p3/            ← Non-optimal solutions
├── solution_n0.6_p2/
└── ...
```

### 2. Why `solution_optimal_*` Glob Pattern Fails on AWS HealthOmics

**The Problem:**  
AWS HealthOmics (and most workflow engines like Cromwell) require **deterministic output paths** in WDL. The glob pattern `solution_optimal_*` fails because:

1. **Dynamic naming**: The folder name includes the **estimated** normal (`n_0`) and ploidy (`phi_0`) values, e.g., `solution_optimal_n0.5_p2`
2. **Unpredictable**: The `n0.5` and `p2` parts depend on which solution is ranked #1 by likelihood
3. **WDL limitation**: WDL `output {}` blocks need exact paths or simple globs that don't depend on runtime values

**Example WDL that FAILS:**
```wdl
output {
  File optimal_seg = glob("~{sampleId}/solution_optimal_*/~{sampleId}.seg")[0]  # ← FAILS
}
```

**Why it fails:**
- `glob()` in WDL doesn't expand `*` the same way bash does in some engines
- AWS HealthOmics may require explicit file paths
- The `n` and `p` values are only known after R runs

### 3. Potential Solutions

**Option A: Post-process with tar (current WDL approach)**
The existing WDL already works around this:
```wdl
tar -czvf ~{sampleId}.plots.tar.gz ~{sampleId}/~{sampleId}*
```
This captures everything in one tarball, but loses the solution folder structure.

**Option B: Modify ichorCNA to use predictable folder names**
Change the R code to use:
```r
solution = "/solution_optimal/"  # Fixed name, no n/p suffix
```
Or:
```r
solution = paste0("/solution_", sprintf("%02d", i), "_")  # solution_01, solution_02, etc.
```

**Option C: Use a manifest file**
Have ichorCNA write a `manifest.txt` listing all output paths, then parse it in WDL.

**Option D: Symlink the optimal solution**
Add to R code:
```r
file.symlink(
  paste0(outDir, "/", id, "/solution_optimal_n", n_0, "_p", phi_0),
  paste0(outDir, "/", id, "/solution_optimal")  # Fixed name
)
```

---

### Summary Table: Docker Image Comparison

| Feature | fredhutch/ichorcna:latest | gavinhalab/ichorcna:3.0.0 |
|---------|--------------------------|---------------------------|
| **Base OS** | Debian bookworm | Ubuntu 22.04 |
| **R Version** | 4.2.2 | 4.2.2 |
| **ichorCNA Version** | 0.5.0 (broadinstitute) | **0.6.0** (GavinHaLab) |
| **Image Size** | 3.44 GB | 3.67 GB |
| **Solution Folders** | ❌ No | ✅ Yes |
| **Per-solution outputs** | ❌ Only optimal | ✅ All solutions |
| **optparse** | ❌ Missing | ❌ Missing |
| **Correction plots** | ❌ No | ✅ Yes (per-chr) |
| **Replication timing** | ❌ Limited | ✅ Full support |
| **hg38 PoN** | ⚠️ Old | ✅ Fixed |

---

### Questions for You

1. **Do you need all solution outputs or just the optimal?**  
   - If just optimal: We can modify the WDL to use a fixed output path
   - If all: We need to handle the dynamic naming

2. **For AWS HealthOmics specifically:**  
   - Can you share the exact WDL task that's failing?
   - What error message does it produce?

3. **Recommendation:**  
   - For **production use**: Use `gavinhalab/ichorcna:3.0.0` (newer, more features)
   - Add `optparse` if using command-line scripts
   - Modify WDL to handle solution folder outputs properly

Would you like me to draft a plan to:
1. Create a modified Dockerfile that adds optparse to gavinhalab's image?
2. Propose WDL modifications to handle the solution folders?
3. Write a report documenting all these findings?

---

## User

does the search space for the optimal soluton include bin size?

---

## Assistant

No, **bin size is NOT part of the solution search space** in ichorCNA.

Let me clarify the distinction:

## What IS in the Solution Search Space (HMM optimization)

The "solutions" in ichorCNA refer to different **initial parameter combinations** for the HMM:

| Parameter | Search Space Example | Description |
|-----------|---------------------|-------------|
| `normal` | `c(0.5, 0.6, 0.7, 0.8, 0.9, 0.95)` | Initial normal contamination (1 - tumor fraction) |
| `ploidy` | `c(2, 3, 4)` | Initial tumor ploidy |

Each combination runs the EM algorithm and produces a solution ranked by **log-likelihood**.

## What is NOT in the Solution Search Space

**Bin size is a pre-processing parameter**, set BEFORE ichorCNA runs:

```bash
# Step 1: readCounter generates WIG file with fixed bin size
readCounter sample.bam -w 10000 -q 20 > sample.bin10000.wig

# Step 2: ichorCNA uses whatever bin size is in the WIG file
# It does NOT search over bin sizes
```

### Bin size is determined by:
1. **GC/Mappability WIG files**: Must match the bin size (e.g., `gc_hg38_10kb.wig`)
2. **Panel of Normals**: Must be generated with same bin size
3. **readCounter output**: The WIG file from BAM

### Common bin sizes:
| Bin Size | Use Case |
|----------|----------|
| 10kb | High resolution, more bins, slower |
| 50kb | Default for cfDNA |
| 500kb | Lower resolution, fewer bins, faster |
| 1Mb | Very low coverage samples |

## Summary

```
Pre-processing (FIXED)         HMM Search Space (OPTIMIZED)
─────────────────────          ────────────────────────────
• Bin size                     • Normal contamination (n)
• Reference genome (hg19/38)   • Ploidy (p)
• Chromosome style (UCSC/NCBI) • Subclonal states
• Mappability threshold        
• GC correction files          
```

If you want to compare results across bin sizes, you'd need to run ichorCNA **multiple times** with different WIG files (generated at different bin sizes) and compare the outputs manually. This is not automated in the tool.

---

## User

so the PON also has diff matching bin sizes here?

---

## Assistant

Yes, exactly! The Panel of Normals (PoN) must match the bin size. Let me show you what's available:

```
Tool: bash
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

## Reference Files by Bin Size

Here's the complete picture of what must match:

| Bin Size | GC WIG | Map WIG | PoN (hg19) | PoN (hg38) |
|----------|--------|---------|------------|------------|
| **10kb** | ✅ `gc_hg19_10kb.wig` | ✅ `map_hg19_10kb.wig` | ❌ None provided | ❌ None provided |
| **50kb** | ✅ `gc_hg19_50kb.wig` | ✅ `map_hg19_50kb.wig` | ❌ None provided | ❌ None provided |
| **500kb** | ✅ `gc_hg19_500kb.wig` | ✅ `map_hg19_500kb.wig` | ✅ `HD_ULP_PoN_500kb_...` | ✅ `HD_ULP_PoN_hg38_500kb_...` |
| **1Mb** | ✅ `gc_hg19_1000kb.wig` | ✅ `map_hg19_1000kb.wig` | ✅ `HD_ULP_PoN_1Mb_...` | ✅ `HD_ULP_PoN_hg38_1Mb_...` |

### Key Observations:

1. **Pre-built PoN only for 500kb and 1Mb** - If you want 10kb or 50kb resolution, you need to create your own PoN using `createPanelOfNormals.R`

2. **All must match:**
   ```
   readCounter -w 500000  →  sample.wig (500kb bins)
                              ↓
   gc_hg38_500kb.wig  ──────┐
   map_hg38_500kb.wig ──────┼──→ ichorCNA
   HD_ULP_PoN_hg38_500kb_...rds ─┘
   ```

3. **Mismatch = Error:** If your WIG has 10kb bins but you use 500kb PoN, ichorCNA will fail or produce garbage results.

### Why No 10kb/50kb PoN?

Creating a PoN requires **many normal samples** (typically 10-50+) processed at the same bin size. The pre-built PoNs are from the original ichorCNA paper using ULP-WGS normals at 500kb/1Mb resolution.

For higher resolution (10kb/50kb), you'd need to:
1. Collect your own normal samples
2. Run `readCounter` at your desired bin size
3. Run `createPanelOfNormals.R` to generate the PoN

Would you like me to document this bin size dependency in the comparison report?

---

## User

I am thinking of forking gavin's repo (has newer content and better maintained) to update and test run ichor, is there any branch that I should pay attention to or just the master is fine? https://github.com/GavinHaLab/ichorCNA#

---

## Assistant

Let me check the GavinHaLab repository for branches and release structure:

```
Tool: webfetch
```

```
Tool: bash
```

---

## Assistant

Interesting! The web shows there are **active branches `v0.6.1` and `v0.4.1`** that were updated on Dec 9, 2025 (very recent!). Let me check those:

```
Tool: bash
```

---

## Assistant

```
Tool: webfetch
```

---

## Assistant

Now I see it! There's a `v0.6.1` branch that was updated very recently (Dec 9, 2025). Let me compare the branches:

```
Tool: webfetch
```

---

## Assistant

Excellent find! The `v0.6.1` branch has **2 new commits from Dec 5, 2025** by Pooja that removes `eval(parse())` from parameter parsing - this is a security/robustness improvement!

Let me also check the open PRs:

```
Tool: webfetch
```

---

## Assistant

Now I have a complete picture. Here's my recommendation:

---

## Branch Recommendation for Forking GavinHaLab/ichorCNA

### Summary of Branches

| Branch | Status | Last Updated | Key Features |
|--------|--------|--------------|--------------|
| **`master`** | Default | Jun 9, 2024 | Stable, v0.5.1 code (README says maintained by GavinHaLab) |
| **`v0.6.1`** | Active development | Dec 9, 2025 | Solution folders + **removes `eval(parse())` security issue** |
| **`v0.4.1`** | Old dev branch | Dec 9, 2025 | Unknown purpose (likely backport) |

### Open Pull Requests (2)

| PR | Description | Status |
|----|-------------|--------|
| **#28** `v0.6.1` | Merge v0.6.1 into master | Open (Dec 9, 2025) |
| **#26** | Fix counting reads when sex chromosomes aren't available | Open (Dec 2, 2025) |

### Releases

| Release | Date | Notes |
|---------|------|-------|
| **v0.6.0** | Nov 22, 2024 | **Latest release** - Solution folders feature |
| v0.5.1 | Earlier | Bug fixes |
| v0.5.0 | Earlier | Base for WDL pipeline |

---

## My Recommendation

### Option 1: Fork from `v0.6.1` branch (Recommended for cutting-edge)

**Pros:**
- Has the newest code (Dec 2025)
- Includes solution folder feature (v0.6.0)
- **Removes `eval(parse())`** - security/robustness improvement
- Active development by Pooja (GavinHaLab maintainer)

**Cons:**
- Not yet merged to master (PR #28 pending)
- May have untested edge cases

**Command:**
```bash
git clone -b v0.6.1 https://github.com/GavinHaLab/ichorCNA.git
```

### Option 2: Fork from tag `v0.6.0` (Recommended for stability)

**Pros:**
- Official release
- Solution folder feature
- Used in gavinhalab/ichorcna:3.0.0 Docker image
- Known to work

**Cons:**
- Still has `eval(parse())` (less safe parameter parsing)
- Missing the Dec 2025 fix

**Command:**
```bash
git clone https://github.com/GavinHaLab/ichorCNA.git
cd ichorCNA
git checkout v0.6.0
```

### Option 3: Fork from `master` (Conservative)

**Pros:**
- Most stable, default branch

**Cons:**
- Missing solution folders feature (v0.6.0)
- Missing Dec 2025 improvements

---

## My Suggestion

**Start with `v0.6.1` branch** for your fork because:

1. It has the solution folder feature you want to test
2. The `eval(parse())` fix is a good security practice
3. It's actively maintained (updated Dec 9, 2025)
4. You can monitor PR #28 - when it merges to master, you can rebase

**Also worth noting:** PR #26 fixes sex chromosome handling - you may want to cherry-pick that if you work with samples missing chrX/chrY.

---

## Questions for You

1. **Do you plan to contribute back upstream?** If so, forking from `v0.6.1` and submitting PRs would align with their development flow.

2. **What's your tolerance for potential bugs?** If low, stick with `v0.6.0` tag (released version).

3. **Will you be running on AWS HealthOmics?** If so, you may want to also look at modifying the WDL to handle the `solution_optimal_*` glob issue we discussed earlier.

---

## User

so - we should use 0.6.0 right? Is this what their container is based on?

---

## Assistant

Yes, exactly! Let me confirm by checking the Dockerfile again:

```
Tool: bash
```

---

## Assistant

Let me reference what we fetched earlier from the GavinHaLab WDL Dockerfile:

From the Dockerfile we fetched earlier (`https://raw.githubusercontent.com/GavinHaLab/ichorCNA_WDL/main/Docker/Dockerfile`):

```dockerfile
# ichorCNA from GitHub
RUN R -e ".libPaths(Sys.getenv('R_LIBS_SITE')); \
          remotes::install_github('GavinHaLab/ichorCNA@v0.6.0', dependencies=TRUE, upgrade='never')"

# ...

RUN wget https://github.com/GavinHaLab/ichorCNA/archive/refs/tags/v0.6.0.zip && \
    unzip v0.6.0.zip && mv ichorCNA-0.6.0/ ichorCNA/ && rm v0.6.0.zip
```

---

## Confirmed: `gavinhalab/ichorcna:3.0.0` is based on `v0.6.0`

| Container | ichorCNA Version | Source |
|-----------|------------------|--------|
| `gavinhalab/ichorcna:3.0.0` | **v0.6.0** | `GavinHaLab/ichorCNA@v0.6.0` tag |
| `gavinhalab/ichorcna:1.0.0` | v0.5.0 | Older version |
| `fredhutch/ichorcna:latest` | ~0.5.0 | broadinstitute/ichorCNA (original) |

---

## Recommendation

**Yes, fork from `v0.6.0` tag** - this ensures:

1. ✅ You're using the same code as the tested Docker container
2. ✅ Solution folders feature included
3. ✅ Known to work with the WDL pipeline
4. ✅ Official release (not a development branch)

**To fork:**
```bash
# Clone and checkout the v0.6.0 tag
git clone https://github.com/GavinHaLab/ichorCNA.git
cd ichorCNA
git checkout v0.6.0

# Or fork on GitHub first, then:
git clone https://github.com/YOUR_ORG/ichorCNA.git
cd ichorCNA
git checkout v0.6.0
git checkout -b main  # Create your own main branch from v0.6.0
```

**Optional:** Once your fork is stable, you can later cherry-pick the `v0.6.1` improvements (the `eval(parse())` fix) if desired.

Would you like me to document all of this in a report before you proceed with the fork?

---

## User

yes - document what we have done today in today's report.

---

## Assistant

```
Tool: todowrite
```

---

## Assistant

```
Tool: read
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

```
Tool: todowrite
```

---

## Assistant

```
Tool: write
```

---

## Assistant

```
Tool: todowrite
```

---

## Assistant

```
Tool: write
```

---

## Assistant

```
Tool: todowrite
```

---

## Assistant

```
Tool: write
```

---

## Assistant

```
Tool: todowrite
```

---

## Assistant

```
Tool: bash
```

---

## Assistant

Done! Here's the manifest:

---

**MANIFEST**

```
saved_dir: documentation/reports/2025-12-15/ichorcna-docker-comparison-2025-12-15/
files:
  - report.md      (11,624 bytes) - Comprehensive analysis documentation
  - report.json    (4,926 bytes)  - Machine-readable report
  - results.csv    (806 bytes)    - Container comparison table
```

Open: `documentation/reports/2025-12-15/ichorcna-docker-comparison-2025-12-15/report.md`

---

**Summary of Today's Work:**

1. Created `ichorCNA-inno.tar.gz` for teammate sharing
2. Compared `fredhutch/ichorcna:latest` vs `gavinhalab/ichorcna:3.0.0`
3. Documented GavinHaLab's 57+ commits of improvements
4. Explained the "solutions" folder feature in v0.6.0
5. Identified AWS HealthOmics glob issue with `solution_optimal_*`
6. Clarified bin size is NOT part of solution search space (PoN must match)
7. **Recommended: Fork from `v0.6.0` tag** (matches container, stable release)

---

