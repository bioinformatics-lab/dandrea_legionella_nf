nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/gatk/haplotype_caller"
params.saveMode = 'copy'
params.shouldPublish = true

process GATK_HAPLOTYPE_CALLER {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    tuple val(genomeName), path(sortedBam)
    path(refFasta)
    path(refFasta_fai)
    tuple path(refFasta_amb), path(refFasta_ann), path(refFasta_bwt), path(refFasta_pac), path(refFasta_sa)
    path(sequenceDictionary)

    output:
    tuple val(genomeName), path("*vcf*")

    script:

    """

    gatk HaplotypeCaller -R ${refFasta} -I ${sortedBam} -O ${genomeName}.vcf
    """

    stub:

    """
    echo "gatk HaplotypeCaller -R ${refFasta} -I ${sortedBam} -O ${genomeName}.vcf"
    touch ${genomeName}.vcf
    """

}
