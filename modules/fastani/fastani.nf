nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/fastani"
params.saveMode = 'copy'
params.shouldPublish = true

process FASTANI {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(filteredContig)
    path(reference)

    output:
    path("${genomeName}.csv")

    script:

    """
    fastAni -t ${task.cpus} -q ${filteredContig} -r ${reference} --visualize -o ${genomeName}.csv
    """

    stub:

    """
    echo "fastAni -t ${task.cpus} -q ${filteredContig} -r ${reference} --visualize -o ${genomeName}.csv"
    """
}


workflow test {

    input_ch = Channel.fromFilePairs("$launchDir/test_data/*_{1,2}.fastq.gz")

    FASTANI(input_ch)

}
