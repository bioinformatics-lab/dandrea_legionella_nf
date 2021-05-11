nextflow.enable.dsl = 2

workflow SNIPPY_ANISA_WF {

    include { SNIPPY as SNIPPY_ANISA } from "./modules/snippy/snippy.nf" addParams(resultsDir: "$baseDir/results/snippy_anisa")

    trimmedReads_ch = Channel.fromFilePairs("$baseDir/results/trimmomatic/37063_{R1,R2}.p.fastq.gz")

    refGbk_ch = Channel.fromPath("$baseDir/data/reference/NZ_CP029563.1_Legionella_anisa.gb")

    SNIPPY_ANISA(trimmedReads_ch, refGbk_ch )
}
