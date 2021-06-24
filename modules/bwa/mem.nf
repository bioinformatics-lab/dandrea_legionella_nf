nextflow.enable.dsl = 2

params.results_dir = "${params.outdir}/bwa/mem"
params.save_mode = 'copy'
params.should_publish = true

process BWA_MEM {
    tag "${genomeName}"
    publishDir params.results_dir, mode: params.save_mode, enabled: params.should_publish


    input:

    tuple val(genomeName), path(genomeReads)
    path(refFasta)
    path(fai)
    tuple path(amb), path(ann), path(bwt), path(pac), path(sa)

    output:
    tuple val(genomeName), path('*.sam')


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
