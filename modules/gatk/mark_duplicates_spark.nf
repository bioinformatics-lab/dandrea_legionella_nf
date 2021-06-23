nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/gatk/mark_duplicates_spark"
params.save_mode = 'copy'
params.should_publish = true

process GATK_MARK_DUPLICATES_SPARK {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

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
