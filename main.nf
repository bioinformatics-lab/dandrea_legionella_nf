import java.nio.file.Paths

nextflow.enable.dsl = 2

include { TRIMMOMATIC } from "./modules/trimmomatic/trimmomatic.nf"
include { SPADES } from "./modules/spades/spades.nf"
include { PROKKA } from "./modules/prokka/prokka.nf"
include { FASTQC as FASTQC_UNTRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_untrimmed")
include { FASTQC as FASTQC_TRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_UNTRIMMED } from "./modules/multiqc/multiqc.nf"
include { MULTIQC as MULTIQC_TRIMMED } from "./modules/multiqc/multiqc.nf"
include { SNIPPY } from "./modules/snippy/snippy.nf"
include { QUAST as QUAST_SPADES } from "./modules/quast/quast.nf" addParams(resultsDir: "${params.outdir}/quast_spades")
include { QUAST as QUAST_UNICYCLER } from "./modules/quast/quast.nf"  addParams(resultsDir: "${params.outdir}/quast_unicycler")
include { UNICYCLER } from "./modules/unicycler/unicycler.nf"


workflow BASE {

    sra_ch = Channel.fromFilePairs(params.reads)

    TRIMMOMATIC(sra_ch)
    SPADES(TRIMMOMATIC.out)
    PROKKA(SPADES.out)
}




workflow QUALITY_CHECK {

    sra_ch = Channel.fromFilePairs(params.reads)

    FASTQC_UNTRIMMED(sra_ch)
//    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out.collect())

    TRIMMOMATIC(sra_ch)
    FASTQC_TRIMMED(TRIMMOMATIC.out)
//    MULTIQC_TRIMMED(FASTQC_TRIMMED.out.collect())
}


workflow WF_SNIPPY {
    sra_ch = Channel.fromFilePairs(params.reads)
    refGbk_ch = Channel.fromPath(Paths.get(params.gbkFile))

    TRIMMOMATIC(sra_ch)
    SNIPPY(TRIMMOMATIC.out, refGbk_ch )
}




workflow SNIPPY_ANISA_WF {

    include { SNIPPY as SNIPPY_ANISA } from "./modules/snippy/snippy.nf" addParams(resultsDir: "$baseDir/results/snippy_anisa")

    trimmedReads_ch = Channel.fromFilePairs("$baseDir/results/trimmomatic/37063_{R1,R2}.p.fastq.gz")

    refGbk_ch = Channel.fromPath("$baseDir/data/reference/NZ_CP029563.1_Legionella_anisa.gb")

    SNIPPY_ANISA(trimmedReads_ch, refGbk_ch )
}



workflow SPADES_WF {
    sra_ch = Channel.fromFilePairs(params.reads)
    TRIMMOMATIC(sra_ch)
    SPADES(TRIMMOMATIC.out)
    QUAST_SPADES(SPADES.out)
}




workflow UNICYCLER_WF {

    trimmedReads_ch = Channel.fromFilePairs("$baseDir/results/trimmomatic/*_{R1,R2}.p.fastq.gz")

    UNICYCLER(trimmedReads_ch)
    QUAST_UNICYCLER(UNICYCLER.out)
}



workflow {

    sra_ch = Channel.fromFilePairs(params.reads)

//    FASTQC_UNTRIMMED(sra_ch)
//    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out)
//    TRIMMOMATIC(sra_ch)
//    FASTQC_TRIMMED(TRIMMOMATIC.out)
//    MULTIQC_TRIMMED(FASTQC_TRIMMED.out)
//    SPADES(TRIMMOMATIC.out)
//    PROKKA(SPADES.out)
//    SNIPPY()
//    QUAST()
}
