nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/prokka"
params.save_mode = 'copy'
params.should_publish = true

process PROKKA {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    tuple val(genomeName), path(bestContig)
    path(reference)

    output:
    path("${genomeName}")

    script:

    """
    prokka --outdir ${genomeName} --prefix ${genomeName} --cpus ${task.cpus} --proteins ${reference} --locustag ${genomeName} ${bestContig}
    """

    stub:

    """
    echo "prokka --outdir ${genomeName} --prefix $genomeName --cpus ${task.cpus} --proteins ${reference} --locustag ${genomeName} ${bestContig}"


    mkdir ${genomeName}

    """
}



workflow test {

    input_ch = Channel.fromFilePairs("$launchDir/test_data/*_{1,2}.fastq.gz")

    params.SPADES = [
            shouldPublish: false
    ]

    include { SPADES } from "../spades/spades.nf" addParams(params.SPADES)

    SPADES(input_ch)

    PROKKA(SPADES.out)


}
