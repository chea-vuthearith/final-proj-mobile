import { Controller, Get, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('menu')
export class MenuController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Get()
  findAll() {
    return this.prisma.menuItem.findMany({ orderBy: { name: 'asc' } });
  }
}