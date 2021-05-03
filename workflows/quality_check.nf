nextflow.enable.dsl = 2

workflow QUALITY_CHECK {

    sra_ch = Channel.fromFilePairs(params.reads)

    FASTQC_UNTRIMMED(sra_ch)
//    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out.collect())

    TRIMMOMATIC(sra_ch)
    FASTQC_TRIMMED(TRIMMOMATIC.out)
//    MULTIQC_TRIMMED(FASTQC_TRIMMED.out.collect())
}
