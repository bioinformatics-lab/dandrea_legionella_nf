nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/samtools/index"
params.saveMode = 'copy'
params.shouldPublish = true

process SAMTOOLS_INDEX {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

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
