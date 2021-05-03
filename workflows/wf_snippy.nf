nextflow.enable.dsl = 2

workflow WF_SNIPPY {
    sra_ch = Channel.fromFilePairs(params.reads)
    refGbk_ch = Channel.fromPath(Paths.get(params.gbkFile))

    TRIMMOMATIC(sra_ch)
    SNIPPY(TRIMMOMATIC.out, refGbk_ch )
}
