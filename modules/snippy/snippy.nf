nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/snippy"
params.saveMode = 'copy'
params.shouldPublish = true

process SNIPPY {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish
    container 'quay.io/biocontainers/snippy:4.6.0--0'

    cpus 8
    memory "15 GB"

    input:
    tuple val(genomeName),  path(bestContig)

    output:
    path("${genomeName}")

    script:
    ram = task.memory.splilt("\\ ")[0]

    """

    snippy --cpus ${task.cpus} --ram ${task.memory} --outdir $genomeName --ref $refGbk --R1 ${genomeReads[0]} --R2 ${genomeReads[1]}

    """

}

