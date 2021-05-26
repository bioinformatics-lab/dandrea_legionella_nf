
process SAMTOOLS_DEPTH {
    publishDir params.depthResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/samtools:1.10--h2e538c0_3'

    input:
    path(refFasta)
    tuple val(genomeName), path(sortedBam)

    output:
    tuple val(genomeName), path("*.txt")

    script:

    """
    samtools depth ${sortedBam} > ${genomeName}_depth_out.txt
    """


    stub:

    """
    echo "samtools depth ${sortedBam} > ${genomeName}_depth_out.txt"
    """

}
