process GATK_HAPLOTYPE_CALLER {
    publishDir params.haplotypeCallerResultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/gatk4:4.1.8.1--py38_0'



    input:
    path(refFasta)
    path("samtoolsIndexResultsDir")
    path("samtoolsFaidxResultsDir")
    path("bwaIndexResultsDir")
    path("picardCreateSequenceDictionaryResultsDir")
    path(sortedBam)

    output:
    path("*vcf*")

    script:
    def sortedBamFileName = sortedBam.toString().split("\\.")[0]

    """
    cp -a samtoolsIndexResultsDir/${sortedBamFileName}* ./
    cp -a samtoolsFaidxResultsDir/* ./
    cp -a bwaIndexResultsDir/* ./
    cp -a picardCreateSequenceDictionaryResultsDir/* ./

    gatk HaplotypeCaller -R ${refFasta} -I ${sortedBam} -O ${sortedBamFileName}.vcf
    """
}
