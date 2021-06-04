nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/bwa/index"
params.saveMode = 'copy'
params.shouldPublish = true

process BWA_INDEX {
    tag "${refFasta}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish


    input:
    path(refFasta)

    output:
    tuple path('*.amb'), path('*.ann'), path('*.bwt'), path('*.pac'), path('*.sa')


    script:
    """
    bwa index ${refFasta}
    """

    stub:
    """
    echo "bwa index ${refFasta}"
    """
}
