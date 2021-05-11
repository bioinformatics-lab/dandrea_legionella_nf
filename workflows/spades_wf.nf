nextflow.enable.dsl = 2

workflow SPADES_WF {
    sra_ch = Channel.fromFilePairs(params.reads)
    TRIMMOMATIC(sra_ch)
    SPADES(TRIMMOMATIC.out)
    QUAST_SPADES(SPADES.out)
}
