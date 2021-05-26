
process SAMTOOLS_INDEX {
    publishDir params.indexResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/samtools:1.10--h2e538c0_3'

    input:
    path(refFasta)
    tuple val(genomeName), path(sortedBam)

    output:
    path("*.bai")

    script:

    """
    samtools index ${sortedBam}
    """

    stub:

    """
    echo "samtools index ${sortedBam}"
    """
}
