nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/bwa/mem"
params.saveMode = 'copy'
params.shouldPublish = true

process BWA_MEM {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish


    input:

    tuple val(genomeName), path(genomeReads)
    path(indexResultsDir)
    path(samtoolsFaidxResultsDir)
    path(refFasta)

    output:

    path('*.sam')


    script:
    def TAG="@RG\\tID:${genomeName}\\tSM:${genomeName}\\tLB:${genomeName}"

    """
    cp ${indexResultsDir}/* .
    cp ${samtoolsFaidxResultsDir}/* .
    bwa mem -K 100000000 -Y  -R "${TAG}\" ${refFasta} ${genomeReads[0]} ${genomeReads[1]} > ${genomeName}.sam
    """

    stub:
    """
    echo "bwa mem -K 100000000 -Y  -R "${TAG}\" ${refFasta} ${genomeReads[0]} ${genomeReads[1]} > ${genomeName}.sam"
    touch ${genomeName}.sam
    """

}
