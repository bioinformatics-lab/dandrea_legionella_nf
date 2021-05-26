nextflow.enable.dsl = 2
import java.nio.file.Paths

params.resultsDir = "${params.outdir}/bwa/index"
params.saveMode = 'copy'
params.shouldPublish = true

process BWA_INDEX {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    container 'quay.io/biocontainers/bwa:0.7.17--hed695b0_7'

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
