nextflow.enable.dsl = 2

include { TRIMMOMATIC } from "./modules/trimmomatic/trimmomatic.nf"
include { SPADES } from "./modules/spades/spades.nf"
include { PROKKA } from "./modules/prokka/prokka.nf"
include { UNICYCLER } from "./modules/unicycler/unicycler.nf"
include { FASTQC as FASTQC_UNTRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_untrimmed")
include { FASTQC as FASTQC_TRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_UNTRIMMED } from "./modules/multiqc/multiqc.nf"
include { MULTIQC as MULTIQC_TRIMMED } from "./modules/multiqc/multiqc.nf"
include { SNIPPY } from "./modules/snippy/snippy.nf"


workflow {

    sra_ch = Channel.fromFilePairs(params.reads)

//    FASTQC_UNTRIMMED(sra_ch)
//    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out)

    TRIMMOMATIC(sra_ch)
//    FASTQC_TRIMMED(TRIMMOMATIC.out)
//    MULTIQC_TRIMMED(FASTQC_TRIMMED.out)
    SPADES(TRIMMOMATIC.out)
    PROKKA(SPADES.out)
//    SNIPPY()
}


