nextflow.enable.dsl = 2

workflow UNICYCLER_WF {

    trimmedReads_ch = Channel.fromFilePairs("$baseDir/results/trimmomatic/*_{R1,R2}.p.fastq.gz")

    UNICYCLER(trimmedReads_ch)
    QUAST_UNICYCLER(UNICYCLER.out)
}
