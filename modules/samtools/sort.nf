nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/samtools/sort"
params.save_mode = 'copy'
params.should_publish = true

process SAMTOOLS_SORT {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(samRead)

    output:
    tuple val(genomeName), path("*sort.bam")

    script:
    """
    samtools sort ${samRead} >  ${genomeName}.sort.bam
    """

    stub:

    """
    echo "samtools sort ${samRead} >  ${genomeName}.sort.bam"
    touch ${genomeName}.sort.bam
    """
}
