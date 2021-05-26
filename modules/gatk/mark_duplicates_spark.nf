process GATK_MARK_DUPLICATES_SPARK {
    publishDir params.markDuplicatesSparkResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/gatk4:4.1.8.1--py38_0'


    when:
    params.markDuplicatesSpark

    input:
    path refFasta from ch_refFasta
    file(samFile) from ch_in_markDuplicatesSpark


    output:
    tuple file("*bam*"),
            file("*_metrics.txt") into ch_out_markDuplicatesSpark


    script:
    samFileName = samFile.toString().split("\\.")[0]

    """
    gatk MarkDuplicatesSpark -I ${samFile} -M ${samFileName}_dedup_metrics.txt -O ${samFileName}.dedup.sort.bam
    """
}
