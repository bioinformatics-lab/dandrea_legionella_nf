nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/gatk/mark_duplicates_spark"
params.saveMode = 'copy'
params.shouldPublish = true

process GATK_MARK_DUPLICATES_SPARK {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(samFile)
    path(refFasta)


    output:
    tuple val(genomeName), path("*dedup.sort.bam")
    path("*_metrics.txt")


    script:

    """
    gatk MarkDuplicatesSpark -I ${samFile} -M ${genomeName}_dedup_metrics.txt -O ${genomeName}.dedup.sort.bam
    """

    stub:

    """
    echo "gatk MarkDuplicatesSpark -I ${samFile} -M ${genomeName}_dedup_metrics.txt -O ${genomeName}.dedup.sort.bam"

    touch ${genomeName}.dedup.sort.bam
    """

}
