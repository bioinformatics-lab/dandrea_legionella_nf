nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/bwa/index"
params.save_mode = 'copy'
params.should_publish = true

process BWA_INDEX {
    tag "${refFasta}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish


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

    touch ${refFasta}.amb
    touch ${refFasta}.ann
    touch ${refFasta}.bwt
    touch ${refFasta}.pac
    touch ${refFasta}.sa
    """
}
