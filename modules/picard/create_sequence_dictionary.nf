nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/picard/create_sequence_dictionary"
params.saveMode = 'copy'
params.shouldPublish = true


process PICARD_CREATE_SEQUENCE_DICTIONARY {
    tag "${refFasta}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

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
