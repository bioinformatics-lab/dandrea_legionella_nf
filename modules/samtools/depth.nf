nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/samtools/depth"
params.saveMode = 'copy'
params.shouldPublish = true

process SAMTOOLS_DEPTH {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

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
