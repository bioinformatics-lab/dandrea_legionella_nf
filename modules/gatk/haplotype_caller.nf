nextflow.enable.dsl = 2

params.resultsDir = "${params.outdir}/gatk/haplotype_caller"
params.saveMode = 'copy'
params.shouldPublish = true

process GATK_HAPLOTYPE_CALLER {
    tag "${genomeName}"
    publishDir params.resultsDir, mode: params.saveMode, enabled: params.shouldPublish

    input:
    path(refFasta)
    path("samtoolsIndexResultsDir")
    path("samtoolsFaidxResultsDir")
    path("bwaIndexResultsDir")
    path("picardCreateSequenceDictionaryResultsDir")
    tuple val(sortedBamFileName), path(sortedBam)

    output:
    tuple val(genomeName), path("*vcf*")

    script:

    """
    cp -a samtoolsIndexResultsDir/${sortedBamFileName}* ./
    cp -a samtoolsFaidxResultsDir/* ./
    cp -a bwaIndexResultsDir/* ./
    cp -a picardCreateSequenceDictionaryResultsDir/* ./

    gatk HaplotypeCaller -R ${refFasta} -I ${sortedBam} -O ${sortedBamFileName}.vcf
    """

    stub:

    """
    echo "gatk HaplotypeCaller -R ${refFasta} -I ${sortedBam} -O ${sortedBamFileName}.vcf"
    touch ${sortedBamFileName}.vcf
    """

}
