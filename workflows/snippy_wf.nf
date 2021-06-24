nextflow.enable.dsl = 2

workflow SNIPPY_WF {
    sra_ch = Channel.fromFilePairs(params.reads)
    refGbk_ch = Channel.fromPath(Paths.get(params.gbk_file))

    TRIMMOMATIC(sra_ch)
    SNIPPY(TRIMMOMATIC.out, refGbk_ch)
}
