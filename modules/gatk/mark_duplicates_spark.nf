nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/gatk/mark_duplicates_spark"
params.saveMode = 'copy'
params.shouldPublish = true

process GATK_MARK_DUPLICATES_SPARK {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    path(refFasta)
    tuple val(samFileName), path(samFile)


    output:
    tuple file("*bam*"), file("*_metrics.txt")


    script:

    """
    gatk MarkDuplicatesSpark -I ${samFile} -M ${samFileName}_dedup_metrics.txt -O ${samFileName}.dedup.sort.bam
    """

    stub:

    """
    echo "gatk MarkDuplicatesSpark -I ${samFile} -M ${samFileName}_dedup_metrics.txt -O ${samFileName}.dedup.sort.bam"

    touch ${samFileName}.dedup.sort.bam
    """

}
