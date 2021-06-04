nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/samtools/faidx"
params.saveMode = 'copy'
params.shouldPublish = true

process SAMTOOLS_FAIDX {
    tag "${refFasta}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    path(refFasta)

    output:
    path('*.fai')

    script:

    """
    samtools faidx ${refFasta}
    """

    stub:
    """
    echo "samtools faidx ${refFasta}"
    touch ${refFasta}.fai
    """

}
