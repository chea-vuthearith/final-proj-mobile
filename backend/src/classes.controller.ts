import { Controller, Get, Post, Body, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('classes')
export class ClassesController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Get()
  findAll() {
    return this.prisma.class.findMany({ include: { prof: true }, orderBy: { name: 'asc' } });
  }

  @Post()
  create(@Body() data: { name: string; desc: string; profId: string; schedule: any; location: string }) {
    return this.prisma.class.create({
      data: {
        name: data.name,
        desc: data.desc,
        profId: data.profId,
        schedule: data.schedule,
        location: data.location,
      },
      include: { prof: true },
    });
  }
}