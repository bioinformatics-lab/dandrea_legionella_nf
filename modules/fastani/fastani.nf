nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/fastani"
params.save_mode = 'copy'
params.should_publish = true

process FASTANI {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(filteredContig)
    path(reference)

    output:
    path("${genomeName}.csv")

    script:

    """
    fastANI -t ${task.cpus} -q ${filteredContig} -r ${reference} --visualize -o ${genomeName}.csv
    """

    stub:

    """
    echo "fastANI -t ${task.cpus} -q ${filteredContig} -r ${reference} --visualize -o ${genomeName}.csv"
    touch ${genomeName}.csv
    """
}


workflow test {

    input_ch = Channel.fromFilePairs("$launchDir/test_data/*_{1,2}.fastq.gz")

    FASTANI(input_ch)

}
