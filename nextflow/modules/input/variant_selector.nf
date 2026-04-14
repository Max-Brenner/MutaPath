process VARIANT_SELECTOR {
    tag "$meta_id.id"
    label 'process_low'
    container 'biocontainers/bcftools:1.17'

    input:
    tuple val(meta_id), path(vcf), path(tbi)

    output:
    tuple val(meta_id), path("*.selected.vcf.gz"), path("*.selected.vcf.gz.tbi"), emit: selected

    script:
    def region_args = params.bed ? "--regions-file ${params.bed}" : ""
    """
    bcftools filter \
        --exclude 'QUAL < 20 || INFO/DP < 10' \
        ${region_args} \
        ${vcf} \
        | bgzip -c > ${meta_id.id}.selected.vcf.gz

    tabix -p vcf ${meta_id.id}.selected.vcf.gz
    """

    stub:
    """
    touch ${meta_id.id}.selected.vcf.gz
    touch ${meta_id.id}.selected.vcf.gz.tbi
    """

}
