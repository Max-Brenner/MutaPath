process REGULATORY_EFFECTS {
    tag "$meta_id.id"
    label 'process_low'
    container 'biocontainers/bedtools:2.31.0'

    input:
    tuple val(meta_id), path(vcf), path(tbi)

    output:
    tuple val(meta_id), path("*.regulatory.bed"), emit: regulatory

    script:
    """
    bedtools intersect \
        -a ${vcf} \
        -b ${params.regulatory_bed} \
        -wa -wb \
        > ${meta_id.id}.regulatory.bed
    """

    stub:
    """
    touch ${meta_id.id}.regulatory.bed
    """

}
