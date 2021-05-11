nextflow.enable.dsl = 2

workflow BASE_WF {

    sra_ch = Channel.fromFilePairs(params.reads)

    TRIMMOMATIC(sra_ch)
    SPADES(TRIMMOMATIC.out)
    PROKKA(SPADES.out)
}
