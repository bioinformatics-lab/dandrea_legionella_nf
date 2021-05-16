import java.nio.file.Paths

nextflow.enable.dsl = 2

// Modules
include { TRIMMOMATIC } from "./modules/trimmomatic/trimmomatic.nf"
include { SPADES } from "./modules/spades/spades.nf"
include { PROKKA } from "./modules/prokka/prokka.nf"
include { FASTQC as FASTQC_UNTRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_untrimmed")
include { FASTQC as FASTQC_TRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_UNTRIMMED } from "./modules/multiqc/multiqc.nf"
include { MULTIQC as MULTIQC_TRIMMED } from "./modules/multiqc/multiqc.nf"
include { SNIPPY } from "./modules/snippy/snippy.nf"
include { QUAST as QUAST_SPADES } from "./modules/quast/quast.nf" addParams(resultsDir: "${params.outdir}/quast_filtered_spades")
include { QUAST as QUAST_UNICYCLER } from "./modules/quast/quast.nf" addParams(resultsDir: "${params.outdir}/quast_filtered_unicycler")
include { UNICYCLER } from "./modules/unicycler/unicycler.nf"

// Workflows
include { BASE_WF } from "./workflows/base_wf.nf"
include { QUALITY_CHECK_WF } from "./workflows/quality_check_wf.nf"
include { SNIPPY_WF } from "./workflows/snippy_wf.nf"
include { SNIPPY_ANISA_WF } from "./workflow/snippy_anisa_wf.nf"
include { SPADES_WF } from "./workflow/spades_wf.nf"
include { UNICYCLER_WF } from "./workflow/unicycler_wf.nf"
include { QUAST_WF } from "./workflow/quast_wf.nf"


workflow {

    sra_ch = Channel.fromFilePairs(params.reads)

//    FASTQC_UNTRIMMED(sra_ch)
//    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out)
//    TRIMMOMATIC(sra_ch)
//    FASTQC_TRIMMED(TRIMMOMATIC.out)
//    MULTIQC_TRIMMED(FASTQC_TRIMMED.out)
//    SPADES(TRIMMOMATIC.out)
//    PROKKA(SPADES.out)
//    SNIPPY()
//    QUAST()
}
