nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/samtools/sort"
params.saveMode = 'copy'
params.shouldPublish = true

process SAMTOOLS_SORT {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(bamRead)

    output:
    path("*sort.bam")

    script:
    """
    samtools sort ${bamRead} >  ${genomeName}.sort.bam
    """

    stub:

    """
    echo "samtools sort ${bamRead} >  ${genomeName}.sort.bam"
    """
}
