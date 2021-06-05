nextflow.enable.dsl = 2

// Modules
include { TRIMMOMATIC } from "./modules/trimmomatic/trimmomatic.nf"
include { SPADES } from "./modules/spades/spades.nf"
include { PROKKA } from "./modules/prokka/prokka.nf"
include { FASTQC as FASTQC_UNTRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_untrimmed")
include { FASTQC as FASTQC_TRIMMED } from "./modules/fastqc/fastqc.nf" addParams(resultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_TRIMMED } from "./modules/multiqc/multiqc.nf" addParams(resultsDir: "${params.outdir}/multiqc_trimmed", fastqcResultsDir: "${params.outdir}/fastqc_trimmed")
include { MULTIQC as MULTIQC_UNTRIMMED } from "./modules/multiqc/multiqc.nf" addParams(resultsDir: "${params.outdir}/multiqc_untrimmed", fastqcResultsDir: "${params.outdir}/fastqc_untrimmed")
include { SNIPPY } from "./modules/snippy/snippy.nf"
include { QUAST } from "./modules/quast/quast.nf" addParams(resultsDir: "${params.outdir}/quast")
include { QUAST as QUAST_UNICYCLER } from "./modules/quast/quast.nf" addParams(resultsDir: "${params.outdir}/quast_filtered_unicycler")
include { UTILS_FILTER_CONTIGS } from "./modules/utils/filter_contigs/filter_contigs.nf"
include { CLASSIFY_TAXONOMY } from "./workflows/classify_taxonomy/classify_taxonomy.nf"
include { FASTANI } from "./modules/fastani/fastani.nf"
include {    BWA_INDEX} from "./modules/bwa/index.nf"
include {    BWA_MEM} from "./modules/bwa/mem.nf"
include {    SAMTOOLS_INDEX} from "./modules/samtools/index.nf"
include {    SAMTOOLS_FAIDX} from "./modules/samtools/faidx.nf"
include {    SAMTOOLS_SORT} from "./modules/samtools/sort.nf"
include {    GATK_HAPLOTYPE_CALLER} from "./modules/gatk/haplotype_caller.nf"
include {    GATK_MARK_DUPLICATES_SPARK} from "./modules/gatk/mark_duplicates_spark.nf"
include {    PICARD_CREATE_SEQUENCE_DICTIONARY} from "./modules/picard/create_sequence_dictionary.nf"

// Workflows
//include { BASE_WF } from "./workflows/base_wf.nf"
//include { QUALITY_CHECK_WF } from "./workflows/quality_check_wf.nf"
//include { SNIPPY_WF } from "./workflows/snippy_wf.nf"
//include { SNIPPY_ANISA_WF } from "./workflows/snippy_anisa_wf.nf"
//include { SPADES_WF } from "./workflows/spades_wf.nf"
//include { UNICYCLER_WF } from "./workflows/unicycler_wf.nf"
//include { QUAST_WF } from "./workflows/quast_wf.nf"


workflow {

    sra_ch = Channel.fromFilePairs(params.reads)

    // Step-1 : QC
    FASTQC_UNTRIMMED(sra_ch)
    MULTIQC_UNTRIMMED(FASTQC_UNTRIMMED.out.flatten().collect())
    TRIMMOMATIC(sra_ch)
    FASTQC_TRIMMED(TRIMMOMATIC.out)
    MULTIQC_TRIMMED(FASTQC_TRIMMED.out.flatten().collect())


    // Step-2
    SPADES(TRIMMOMATIC.out)
    UTILS_FILTER_CONTIGS(SPADES.out[0])
    // NOTE This quast command operates on all contig
    // There is another one, mentioned in the module for a single contig
    QUAST(UTILS_FILTER_CONTIGS.out[0].collect(), params.reference_fasta)
    PROKKA(UTILS_FILTER_CONTIGS.out[1], params.reference_fasta)
    SNIPPY(TRIMMOMATIC.out, params.reference_fasta)


    // Step-3
    FASTANI(UTILS_FILTER_CONTIGS.out[1], params.reference_fasta)


    // Step-4
    BWA_INDEX(params.reference_fasta)
    SAMTOOLS_FAIDX(params.reference_fasta)
    PICARD_CREATE_SEQUENCE_DICTIONARY(params.reference_fasta)
    CLASSIFY_TAXONOMY(TRIMMOMATIC.out)

    // Step-5
    // BWA_MEM()
    // SAMTOOLS_INDEX()
    // SAMTOOLS_SORT()
    // GATK_HAPLOTYPE_CALLER()
    // GATK_MARK_DUPLICATES_SPARK()
    // BLAST()
}
