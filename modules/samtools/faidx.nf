
process SAMTOOLS_FAIDX {
    tag "${refFasta}"
    publishDir params.faidxResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/samtools:1.10--h2e538c0_3'

    input:
    path refFasta

    output:
    tuple path('*.fai')

    script:

    """
    samtools faidx ${refFasta}
    """

    stub:
    """
    echo "samtools faidx ${refFasta}"
    """

}
