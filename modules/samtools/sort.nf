
process SAMTOOLS_SORT {
    publishDir params.sortResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/samtools:1.10--h2e538c0_3'

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
