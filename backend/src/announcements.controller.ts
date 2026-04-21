import { Controller, Get, Post, Body, Inject } from '@nestjs/common';
import { PrismaService } from './prisma.service';

@Controller('announcements')
export class AnnouncementsController {
  constructor(@Inject(PrismaService) private prisma: PrismaService) {}

  @Get()
  findAll() {
    return this.prisma.announcement.findMany({ orderBy: { createdAt: 'desc' } });
  }

  @Post()
  create(@Body() data: { title: string; content: string }) {
    return this.prisma.announcement.create({ data });
  }
}