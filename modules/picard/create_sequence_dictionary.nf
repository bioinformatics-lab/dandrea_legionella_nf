nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/picard/create_sequence_dictionary"
params.save_mode = 'copy'
params.should_publish = true


process PICARD_CREATE_SEQUENCE_DICTIONARY {
    tag "${refFasta}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish

    input:
    path(refFasta)

    output:
    path("*.dict")


    script:
    def refFastaName = refFasta.toString().split("\\.")[0]

    """
    picard CreateSequenceDictionary REFERENCE=${refFasta}  OUTPUT=${refFastaName}.dict
    """

    script:
    refFastaName = refFasta.toString().split("\\.")[0]

    """
    echo "picard CreateSequenceDictionary REFERENCE=${refFasta}  OUTPUT=${refFastaName}.dict"
    touch ${refFastaName}.dict
    """

}
