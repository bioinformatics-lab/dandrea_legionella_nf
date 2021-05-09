
workflow QUAST_WF {

    filtered_spades_ch = Channel.fromPath("$baseDir/results/spades/filtered/*fna").collect()
    QUAST_SPADES(filtered_spades_ch)

    filtered_unicycler_ch = Channel.fromPath("$baseDir/results/unicycler/filtered/*fna").collect()
    QUAST_UNICYCLER(filtered_unicycler_ch)
}
