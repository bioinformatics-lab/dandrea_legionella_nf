nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/fastani"
params.saveMode = 'copy'
params.shouldPublish = true

process FASTANI {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(genomeReads)

    output:
    path("${genomeName}")

    script:

    """
    fastAni -t 20 -q ${TODO} HZ01.fna -r ${reference} --visualize -o ${genomeName}.csv
    """

    stub:

    """

    """
}


workflow test {

    input_ch = Channel.fromFilePairs("$launchDir/test_data/*_{1,2}.fastq.gz")

    FASTANI(input_ch)

}
