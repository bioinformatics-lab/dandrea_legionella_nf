nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/samtools/faidx"
params.save_mode = 'copy'
params.should_publish = true

process SAMTOOLS_FAIDX {
    tag "${refFasta}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

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
