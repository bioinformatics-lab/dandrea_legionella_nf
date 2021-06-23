nextflow.enable.dsl = 2


params.save_mode = 'copy'
params.results_dir = "${params.outdir}/quast"
params.should_publish = true


process QUAST {
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path(contigFiles)
    path(reference)

    output:
    path("quast_results")


    script:

// NOTE This command is for an individual contig file
// quast -r ${reference}  --circos ${filtered_contig}

    """
    quast -r ${reference} -t ${task.cpus} ${contigFiles}

    """

    stub:
    """
    echo "quast -r ${reference} -t ${task.cpus} ${contigFiles}"

    mkdir quast_results

    """
}

workflow test {
    include { TRIMMOMATIC } from "../trimmomatic/trimmomatic.nf"
    include { SPADES } from "../spades/spades.nf"

    input_reads_ch = Channel.fromFilePairs("$launchDir/data/mock_data/*_{R1,R2}*fastq.gz")

    TRIMMOMATIC(input_reads_ch)

    SPADES(TRIMMOMATIC.out)

    QUAST(SPADES.out.collect())

}

