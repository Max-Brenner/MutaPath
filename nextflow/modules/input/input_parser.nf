process INPUT_PARSER {
    tag "$meta_id.id"
    label 'process_low'
    container 'biocontainers/bcftools:1.17'

    input:
    tuple val(meta_id), path(vcf), path(reference), path(gtf)

    output:
    tuple val(meta_id), path("*.parsed.vcf.gz"), path("*.parsed.vcf.gz.tbi"), emit: parsed

    script:
    """
    bcftools view ${vcf} \
        | bcftools norm -f ${reference} -m -any \
        | bcftools sort \
        | bgzip -c > ${meta_id.id}.parsed.vcf.gz

    tabix -p vcf ${meta_id.id}.parsed.vcf.gz
    """

    stub:
    """
    touch ${meta_id.id}.parsed.vcf.gz
    touch ${meta_id.id}.parsed.vcf.gz.tbi
    """

}
