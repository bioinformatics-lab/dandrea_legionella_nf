nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/samtools/index"
params.save_mode = 'copy'
params.should_publish = true

process SAMTOOLS_INDEX {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(sortedBam)
    path(refFasta)

    output:
    tuple val(genomeName), path("*.bai"), path(sortedBam)

    script:

    """
    samtools index ${sortedBam}
    """

    stub:

    """
    echo "samtools index ${sortedBam}"
    touch ${sortedBam}.bai
    """
}
